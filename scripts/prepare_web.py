import html
import json
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

from PIL import Image


ROOT = Path(__file__).resolve().parent.parent

WEB_DIR = ROOT / "web"

FAVICON_SOURCE = (
    ROOT
    / "lib"
    / "assets"
    / "home"
    / "monogram_ad_wreath.png"
)

FAVICON_SIZE = 48

PROJECT_NAME = "alisha_dawid_wedding_website"


def run(command: list[str], cwd: Path | None = None) -> None:
    print()
    print(f"==> {' '.join(command)}")

    subprocess.run(
        command,
        cwd=cwd or ROOT,
        check=True,
    )


def get_app_title() -> str:
    script = ROOT / "scripts" / "fetch_app_title.py"

    result = subprocess.run(
        [sys.executable, str(script)],
        cwd=ROOT,
        check=True,
        capture_output=True,
        text=True,
    )

    title = result.stdout.strip()

    if not title:
        raise RuntimeError(
            "scripts/fetch_app_title.py returned an empty app title."
        )

    return title


def regenerate_web_folder() -> None:
    print()
    print("==> Regenerating Flutter web template")

    with tempfile.TemporaryDirectory(
        prefix="flutter_web_template_"
    ) as temp_dir:
        temp_path = Path(temp_dir)

        run(
            [
                "flutter",
                "create",
                "--platforms=web",
                "--project-name",
                PROJECT_NAME,
                "--no-pub",
                str(temp_path),
            ]
        )

        generated_web = temp_path / "web"

        if not (generated_web / "index.html").exists():
            raise RuntimeError(
                "Flutter did not generate web/index.html."
            )

        if WEB_DIR.exists():
            shutil.rmtree(WEB_DIR)

        shutil.copytree(
            generated_web,
            WEB_DIR,
        )


def update_index(app_title: str) -> None:
    print()
    print("==> Updating web/index.html")

    index_path = WEB_DIR / "index.html"

    content = index_path.read_text(
        encoding="utf-8",
    )

    encoded_title = html.escape(
        app_title,
        quote=True,
    )

    import re

    content = re.sub(
        r'<meta name="description" content=".*?">',
        (
            '<meta name="description" '
            f'content="{encoded_title}">'
        ),
        content,
    )

    if re.search(
        r"<title>.*?</title>",
        content,
        flags=re.DOTALL,
    ):
        content = re.sub(
            r"<title>.*?</title>",
            f"<title>{encoded_title}</title>",
            content,
            flags=re.DOTALL,
        )
    else:
        content = content.replace(
            "</head>",
            f"  <title>{encoded_title}</title>\n</head>",
        )

    index_path.write_text(
        content,
        encoding="utf-8",
    )


def update_manifest(app_title: str) -> None:
    print()
    print("==> Updating web/manifest.json")

    manifest_path = WEB_DIR / "manifest.json"

    if not manifest_path.exists():
        raise RuntimeError(
            "web/manifest.json was not generated."
        )

    manifest = json.loads(
        manifest_path.read_text(
            encoding="utf-8",
        )
    )

    manifest["name"] = app_title
    manifest["short_name"] = "Wedding"

    manifest_path.write_text(
        json.dumps(
            manifest,
            indent=2,
            ensure_ascii=False,
        ),
        encoding="utf-8",
    )


def update_favicon() -> None:
    print()
    print("==> Creating favicon")

    if not FAVICON_SOURCE.exists():
        raise RuntimeError(
            f"Favicon source not found: {FAVICON_SOURCE}"
        )

    destination = WEB_DIR / "favicon.png"

    with Image.open(FAVICON_SOURCE) as source:
        source = source.convert("RGBA")

        resized = source.resize(
            (FAVICON_SIZE, FAVICON_SIZE),
            Image.Resampling.LANCZOS,
        )

        resized.save(
            destination,
            format="PNG",
        )


def main() -> None:
    app_title = get_app_title()

    print()
    print(f"Using app title: {app_title}")

    regenerate_web_folder()
    update_index(app_title)
    update_manifest(app_title)
    update_favicon()

    print()
    print("Web preparation complete.")


if __name__ == "__main__":
    main()