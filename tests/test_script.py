import sys
import os

# Add the src directory to the Python path
sys.path.insert(
    0, os.path.abspath(os.path.join(os.path.dirname(__file__), "..", "src"))
)

from script import main


def test_main_output(capsys):
    # Call the main function
    main()

    # Capture the output
    captured = capsys.readouterr()

    # Assert that the output is correct
    assert captured.out.strip() == "Hello, world!"


def test_main_no_error():
    # Test that the main function runs without raising any exceptions
    try:
        main()
    except Exception as e:
        pytest.fail(f"main() raised {type(e).__name__} unexpectedly!")
