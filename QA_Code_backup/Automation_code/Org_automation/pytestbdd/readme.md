
# Pytest

Pytest for both Metadata and unzip functions were handled.

## Clone Project
Using Bitbucket, clone the project.
```bash
Git clone https://sourcecode.jnj.com/projects/ASX-NAYL/repos/anchor_octave/commits?until=refs%2Fheads%2Ffeature%2FJAYU-2179#:~:text=https%3A//sourcecode.jnj.com/scm/asx%2Dnayl/anchor_octave.git 

```
## Project setup
Download and install the VS code for Windows.

```bash
https://www.jetbrains.com/pycharm/download/#section=windows
```
Go to the project directory
```bash
cd test
```
## Install dependencies
Open pycharm install dependencies

```bash
python -m pip install -r test/requirements.txt
```

```bash
python execute.py --test_execution_id=JAYU-2120 --test_ids=JAYU-2110,JAYU-2109,JAYU-2108,JAYU-2107,JAYU-2106,JAYU-2105,JAYU-2102,JAYU-2134 --xray_upload=no_upload --env=Dev --user_id=VRajaC
```
