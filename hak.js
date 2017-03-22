function hak (rules, input) {
    var output = input;
    while (true) {
        for (let [key, value] of Object.entries(rules)) {
            output = output.replace(key, value);
            $('#debug').text(key, value);
        }
        if (output == input)
            break;
        input = output;
    }
    return output;
}

function main () {
    var rulesText = $('#rules').val();
    var input = $('#input').val();
    var rules;
    rules = JSON.parse(rulesText); // FIXME: deal with errors and output that is not an object
    $('#output').text(hak(rules, input));
}
