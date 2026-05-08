"""
Run robot tests and store results as timestamped test evidence.

Usage:
    python scripts/run_tests.py --org dev_namespaced_1 --suite rates
    python scripts/run_tests.py --org dev_namespaced_1 --suite requests
    python scripts/run_tests.py --org dev_namespaced_1                    # runs all
    python scripts/run_tests.py --org dev_namespaced_1 --suite rates --test RATES-010*

Evidence is stored in:
    robot/evidence/<YYYY-MM-DD_HH-MM-SS>_<suite>_<org>/
        report.html
        log.html
        output.xml
        tests/
            <test-name>/
                result.txt          (PASS/FAIL, duration, error message)
                screenshot_001.png
                screenshot_002.png
                ...
        videos/
"""

import argparse
import re
import shutil
import subprocess
import sys
import xml.etree.ElementTree as ET
from datetime import datetime
from pathlib import Path


def find_video_for_suite(suite_elem):
    """Find the video filename from a suite's setup keyword messages."""
    # Videos are logged in the Suite Setup's "Open Test Browser With Video" keyword
    # as <video> HTML tags or video_path in message text
    for kw in suite_elem.findall("kw"):
        if kw.get("type") == "SETUP":
            for msg in kw.iter("msg"):
                if msg.text and msg.get("html") == "true" and ".webm" in msg.text:
                    # Extract from <source src="browser/video/page%40xxx.webm">
                    match = re.search(r'src="([^"]*\.webm)"', msg.text)
                    if match:
                        # URL-decode %40 -> @
                        return match.group(1).replace("%40", "@")
                if msg.text and "video_path" in msg.text:
                    match = re.search(r"video_path['\"]:\s*['\"]([^'\"]+\.webm)", msg.text)
                    if match:
                        return match.group(1)
    return None


def parse_output_xml(output_xml_path):
    """Parse output.xml to map screenshots and videos to individual test cases."""
    # Clean invalid XML characters before parsing
    with open(output_xml_path, "r", encoding="utf-8", errors="replace") as f:
        text = f.read()
    # Remove characters invalid in XML 1.0
    import re as _re
    text = _re.sub(r'[\x00-\x08\x0b\x0c\x0e-\x1f\x7f]', '', text)
    root = ET.fromstring(text)

    test_results = []

    # Walk suite elements to map videos to their test cases
    for suite in root.iter("suite"):
        video_path = find_video_for_suite(suite)
        tests_in_suite = suite.findall("test")

        for test in tests_in_suite:
            test_name = test.get("name", "unknown")
            status_elem = test.find("status")
            status = status_elem.get("status", "UNKNOWN") if status_elem is not None else "UNKNOWN"
            start = status_elem.get("start", "") if status_elem is not None else ""
            elapsed = status_elem.get("elapsed", "") if status_elem is not None else ""
            error_msg = status_elem.text or "" if status_elem is not None else ""

            # Find all screenshot paths referenced in this test's messages/keywords
            screenshots = []
            for msg in test.iter("msg"):
                if msg.text and msg.get("html") == "true":
                    img_matches = re.findall(r'src="([^"]+\.png)"', msg.text)
                    screenshots.extend(img_matches)
                elif msg.text and ".png" in msg.text:
                    png_matches = re.findall(r'([\w/\\.-]+\.png)', msg.text)
                    screenshots.extend(png_matches)

            test_results.append({
                "name": test_name,
                "status": status,
                "start": start,
                "elapsed": elapsed,
                "error": error_msg.strip(),
                "screenshots": screenshots,
                "video": video_path,
            })

    return test_results


def sanitize_dirname(name):
    """Convert a test name to a safe directory name."""
    # Replace spaces and special chars with underscores
    safe = re.sub(r'[^\w\-]', '_', name)
    # Collapse multiple underscores
    safe = re.sub(r'_+', '_', safe)
    return safe.strip('_')[:80]


def organise_evidence(evidence_dir, temp_output):
    """Parse output.xml and organise screenshots into per-test folders."""
    output_xml = temp_output / "output.xml"
    if not output_xml.exists():
        print("  WARNING: output.xml not found, skipping per-test organisation")
        return

    # Copy main result files
    for filename in ["output.xml", "log.html", "report.html"]:
        src = temp_output / filename
        if src.exists():
            shutil.copy2(src, evidence_dir / filename)

    # Parse output.xml for per-test screenshot and video mapping
    test_results = parse_output_xml(output_xml)
    tests_dir = evidence_dir / "tests"
    tests_dir.mkdir(exist_ok=True)

    screenshot_src = temp_output / "browser" / "screenshot"
    video_src = temp_output / "browser" / "video"

    for test in test_results:
        test_dir_name = sanitize_dirname(test["name"])
        test_dir = tests_dir / test_dir_name
        test_dir.mkdir(exist_ok=True)

        # Write result summary
        result_file = test_dir / "result.txt"
        with open(result_file, "w", encoding="utf-8") as f:
            f.write(f"Test: {test['name']}\n")
            f.write(f"Status: {test['status']}\n")
            f.write(f"Started: {test['start']}\n")
            f.write(f"Elapsed: {test['elapsed']}\n")
            if test["error"]:
                f.write(f"Error: {test['error']}\n")
            f.write(f"Screenshots: {len(test['screenshots'])}\n")
            if test.get("video"):
                f.write(f"Video: video.webm\n")

        # Copy screenshots belonging to this test
        for i, screenshot_ref in enumerate(test["screenshots"], 1):
            screenshot_name = Path(screenshot_ref).name
            src_file = screenshot_src / screenshot_name
            if not src_file.exists():
                src_file = temp_output / screenshot_ref
            if not src_file.exists():
                src_file = temp_output / "browser" / "screenshot" / screenshot_name

            if src_file.exists():
                ext = src_file.suffix
                dst_name = f"screenshot_{i:03d}{ext}"
                shutil.copy2(src_file, test_dir / dst_name)

        # Copy video belonging to this test's suite
        if test.get("video"):
            video_name = Path(test["video"]).name
            video_file = video_src / video_name
            if not video_file.exists():
                video_file = temp_output / test["video"]
            if video_file.exists():
                shutil.copy2(video_file, test_dir / "video.webm")

    # Copy any unmatched screenshots
    if screenshot_src.exists():
        matched_screenshots = set()
        for test in test_results:
            for s in test["screenshots"]:
                matched_screenshots.add(Path(s).name)

        unmatched_dir = tests_dir / "_unmatched_screenshots"
        has_unmatched = False
        for png in screenshot_src.glob("*.png"):
            if png.name not in matched_screenshots:
                if not has_unmatched:
                    unmatched_dir.mkdir(exist_ok=True)
                    has_unmatched = True
                shutil.copy2(png, unmatched_dir / png.name)

    return test_results


def print_summary(evidence_dir, test_results):
    """Print a formatted summary of the test run."""
    print(f"\n{'=' * 70}")
    print(f"  Test Evidence Summary")
    print(f"{'=' * 70}")

    if test_results:
        passed = sum(1 for t in test_results if t["status"] == "PASS")
        failed = sum(1 for t in test_results if t["status"] == "FAIL")
        total = len(test_results)

        for test in test_results:
            status_icon = "PASS" if test["status"] == "PASS" else "FAIL"
            screenshots = len(test["screenshots"])
            has_video = "video" if test.get("video") else "no video"
            print(f"  [{status_icon}] {test['name']}")
            print(f"         {screenshots} screenshots | {has_video} | {test['elapsed']}")
            if test["error"]:
                print(f"         Error: {test['error'][:100]}")

        print(f"\n  Results: {passed} passed, {failed} failed, {total} total")

    # List the evidence directory structure
    print(f"\n  Evidence directory: {evidence_dir}")
    tests_dir = evidence_dir / "tests"
    if tests_dir.exists():
        for test_folder in sorted(tests_dir.iterdir()):
            if test_folder.is_dir():
                files = list(test_folder.iterdir())
                screenshots = sum(1 for f in files if f.suffix == '.png')
                has_video = any(f.suffix == '.webm' for f in files)
                video_str = " + video" if has_video else ""
                print(f"    {test_folder.name}/ ({screenshots} screenshots{video_str})")

    print(f"\n  Open report: {evidence_dir / 'report.html'}")
    print(f"{'=' * 70}")


def main():
    parser = argparse.ArgumentParser(description="Run CFSuite robot tests and store evidence")
    parser.add_argument("--org", required=True, help="CumulusCI org alias (e.g. dev_namespaced_1)")
    parser.add_argument("--suite", default="all", help="Test suite: requests, rates, pulse, or all")
    parser.add_argument("--test", default=None, help="Specific test file pattern (e.g. RATES-010*)")
    args = parser.parse_args()

    # Determine suite path
    project_root = Path(__file__).parent.parent
    if args.suite == "all":
        suite_path = "robot/tests"
    else:
        suite_path = f"robot/tests/{args.suite}"
        if not (project_root / suite_path).exists():
            print(f"ERROR: Suite directory not found: {suite_path}")
            sys.exit(1)

    # Create timestamped evidence directory
    timestamp = datetime.now().strftime("%Y-%m-%d_%H-%M-%S")
    evidence_name = f"{timestamp}_{args.suite}_{args.org}"
    evidence_dir = project_root / "robot" / "evidence" / evidence_name
    evidence_dir.mkdir(parents=True, exist_ok=True)

    # Output dir (matches cumulusci.yml robot task config)
    temp_output = project_root / "robot" / "results"

    # Build CCI command
    cmd = [
        "cci", "task", "run", "robot",
        "--org", args.org,
        "-o", "suites", suite_path,
    ]

    # Add specific test filter if provided
    if args.test:
        cmd.extend(["-o", "test", args.test])

    print(f"{'=' * 70}")
    print(f"  CFSuite Robot Test Runner")
    print(f"{'=' * 70}")
    print(f"  Org:       {args.org}")
    print(f"  Suite:     {args.suite}")
    print(f"  Test:      {args.test or 'all'}")
    print(f"  Evidence:  {evidence_dir.relative_to(project_root)}")
    print(f"{'=' * 70}")
    print()

    # Run the tests
    result = subprocess.run(cmd, cwd=project_root)

    # Organise results into per-test evidence folders
    print(f"\nOrganising evidence into: {evidence_dir.relative_to(project_root)}")
    test_results = organise_evidence(evidence_dir, temp_output)

    # Print summary
    print_summary(evidence_dir, test_results)

    sys.exit(result.returncode)


if __name__ == "__main__":
    main()
