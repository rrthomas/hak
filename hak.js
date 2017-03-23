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
    $('#error').text(""); // Clear any previous error
    try {
        rules = JSON.parse(rulesText);
    } catch (e) {
        $('#error').text(e);
        return;
    }
    $('#output').text(hak(rules, input));
}

$(document).ready(main);
