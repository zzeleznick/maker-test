function get_version {
    output=$(python --version)
}
# Old Python versions just print to STDERR
# Pipe STDERR to STDOUT and ignore STDOUT
get_version 2>&1 >/dev/null | awk '{gsub("Python ", ""); print}'