# Makefile for Python project management

# Variables
VENV_NAME := .venv
PYTHON := python3
PIP := $(VENV_NAME)/bin/pip
PYTHON_VENV := $(VENV_NAME)/bin/python
BLACK := $(VENV_NAME)/bin/black
JUPYTER := $(VENV_NAME)/bin/jupyter
PYTEST := $(VENV_NAME)/bin/pytest
KERNEL_NAME := my_project_kernel

# Check if any Python files exist
PYTHON_FILES := $(shell find . -name "*.py")

# Default target
all: venv install format install-kernel test

# Create virtual environment
venv:
	@echo "Creating virtual environment..."
	@$(PYTHON) -m venv $(VENV_NAME)
	@$(PIP) install --upgrade pip
	@echo "Virtual environment created successfully in $(VENV_NAME)."

# Install dependencies and development tools
install: venv
	@echo "Installing dependencies and development tools..."
	@$(PIP) install --no-cache-dir -r requirements.txt
	@$(PIP) install black jupyter jupyterlab notebook ipykernel pandas numpy matplotlib seaborn scikit-learn pytest
	@echo "Dependencies and tools installed successfully."

# Format code using Black
format: venv
	@echo "Formatting code with Black..."
	@$(BLACK) src tests
	@echo "Code formatting complete."

# Install Jupyter kernel
install-kernel: install
	@echo "Installing Jupyter kernel..."
	@$(PYTHON_VENV) -m ipykernel install --user --name=$(KERNEL_NAME)
	@echo "Jupyter kernel '$(KERNEL_NAME)' installed."

# Delete Jupyter kernel
delete-kernel:
	@echo "Deleting Jupyter kernel '$(KERNEL_NAME)'..."
	@-jupyter kernelspec uninstall $(KERNEL_NAME) -f
	@echo "Jupyter kernel deleted."

# Clean virtual environment
clean:
	@echo "Cleaning virtual environment..."
	@rm -rf $(VENV_NAME)
	@echo "Virtual environment removed."

# Run tests
# Run tests
test: venv
	@echo "Running tests..."
	@$(PYTEST) -v tests

# ... rest of the Makefile remains unchanged ...

.PHONY: all venv install format install-kernel delete-kernel clean test