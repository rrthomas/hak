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
    if (rulesText != "") { // Do nothing if input is empty (no error)
        var input = $('#input').val();
        var rules;
        $('#error').text(""); // Clear any previous error
        // FIXME: Make better syntax, like Thue
        try {
            rules = jsyaml.safeLoad(rulesText);
            if (typeof(rules) != "object")
                throw("Syntax error: rules are valid YAML, but not an object")
        } catch (e) {
            $('#error').text(e);
            return;
        }
        $('#output').text(hak(rules, input));
    }
}

$(document).ready(main);
