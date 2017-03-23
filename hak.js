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
    try {
        rules = JSON.parse(rulesText);
    } catch (e) {
        $('#output').text(e); // FIXME: Colour it red
    }
    $('#output').text(hak(rules, input));
}
