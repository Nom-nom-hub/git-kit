import typer
from rich.console import Console
from .commands import init, pr, release, status

app = typer.Typer(
    name="git-kit",
    help="Git-Kit: Your GitHub Boss. Automate your methodology.",
    add_completion=False,
)
console = Console()

# Register commands
app.command(name="init", help="Initialize Git-Kit in this repo")(init.main)
app.command(name="status", help="Show project status")(status.main)
app.add_typer(pr.app, name="pr", help="Plan and manage Pull Requests")
app.add_typer(release.app, name="release", help="Plan and manage Releases")


if __name__ == "__main__":
    app()
