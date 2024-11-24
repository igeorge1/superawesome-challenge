# Makefile to automate the setup process for DBT, Ansible, and related dependencies

PYTHON_VERSION = python3
VENV_PATH = venv
DBT_PATH = ansible-dbt-orchestration/playbooks/dbt_super
SEEDS_PATH = $(DBT_PATH)/seeds
CSV_PATH = challenge_requirements/data

# Targets

all: install_requirements copy_seeds run_playbook

#  Install dbt, Ansible and dependencies
install_requirements:
	@echo "Installing dbt, ansible and dependencies..."
	$(PYTHON_VERSION) -m venv $(VENV_PATH)  # Create virtual environment
	. $(VENV_PATH)/bin/activate && $(PYTHON_VERSION) -m pip install -U pip
	. $(VENV_PATH)/bin/activate && $(PYTHON_VERSION) -m pip install dbt-core dbt-duckdb ansible  # Install dbt, duckdb, ansible

# Copy seeds
copy_seeds:
	@echo "Copy CSV files to dbt seeds folder..."
	cp $(CSV_PATH)/*.csv $(SEEDS_PATH)/

# Run the Ansible playbook
run_playbook:
	@echo "Running the Ansible playbook to orchestrate  the DBT project..."
	. $(VENV_PATH)/bin/activate && ansible-playbook -i ansible-dbt-orchestration/inventory/hosts.ini  ansible-dbt-orchestration/playbooks/dbt_orchestration.yml

# Clean up virtual environment
clean:
	@echo "Cleaning up virtual environment..."
	rm -rf $(VENV_PATH)
