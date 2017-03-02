function get_filename {
    output=$(basename $0)
    echo $output
}
function get_dirname {
    output=$(dirname $0)
    echo $output
}
function get_path {
    echo "$(dirname $0)/$(basename $0)"
}

get_path