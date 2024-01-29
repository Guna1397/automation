import re
from dataclasses import dataclass
from itertools import groupby


@dataclass
class LogEntry:
    log_level: str
    timestamp: str
    scenario_id: str
    step: str
    message: str
    line_regex_pattern = r"(\w+) --- (\d{2}:\d{2}:\d{2}) --- (.*?) --- (.*?) --- (.*)"
    outside_log_regex_pattern = r"(\w+) --- (\d{2}:\d{2}:\d{2}) --- (.*?) --- (.*)"

    @staticmethod
    def from_log_entry_line(entry: str):
        regex = re.compile(LogEntry.line_regex_pattern, re.DOTALL)
        ll, timestamp, scenario_id, step, message = regex.search(
            entry).groups()
        return LogEntry(ll, timestamp, scenario_id, step, message)


def load_log_entries() -> list[LogEntry]:
    with open("pytest_logs.txt") as f:
        lines = f.readlines()

    joined_lines = []
    regex = re.compile(LogEntry.line_regex_pattern)
    outside_line_regex = re.compile(LogEntry.outside_log_regex_pattern)

    for line in lines:
        if regex.match(line):
            joined_lines.append(line)
        elif outside_line_regex.match(line):
            continue
        else:
            joined_lines[-1] += line

    return list(map(LogEntry.from_log_entry_line, joined_lines))


def get_logs_for_scenarios() -> dict[dict[list[str]]]:
    log_entries = load_log_entries()

    scenarios_log_entries = {}
    for entry in log_entries:
        scenarios_log_entries.setdefault(entry.scenario_id, []).append(entry)

    for k, log_entries in dict(scenarios_log_entries).items():
        grouped_entries = []
        for _, entries in groupby(log_entries, key=lambda x: x.step):
            grouped_entries.append(list(entries))

        scenarios_log_entries[k] = grouped_entries

    return scenarios_log_entries
