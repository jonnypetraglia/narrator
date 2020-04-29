
function validRegex(input) {
    try {
        return !!(new RegExp(input, 'i'));
    } catch(error) {
        return false;
    }
}

function logMatchesFilter(log, filter, maxLengthToTest) {
    const matcher = (input) => {return typeof filter == RegExp ? filter.test(input) : input.includes(filter); }
    return ['narrate_Message__c', 'narrate_Class__c', 'narrate_Method__c', 'narrate_User__c'].reduce((result, field) => {
        return result || (log[field].length <= maxLengthToTest && matcher(log[field]));
    }, false);
}

function publishEvent(logEvent) {

    return new Promise((resolve, reject) => {
        var xmlhttp = new XMLHttpRequest();
        // TODO: Set url for httprequest
        xmlhttp.onreadystatechange = function() {
            if (xmlhttp.readyState == 4 ) {
                if(resolve) resolve(xmphttp); //TODO: Different val?
            } else {
                if(reject) reject(xmphttp); //TODO: Different val?
            }
        };
        xmlhttp.open("POST", EVENT_URL);
        xmlhttp.send(logEvent);
    })
    .then((what) => {
        console.log("?", what);
    })
    .catch((error) => {
        console.error(error);
    });
}

function formatString(stringToFormat, formattingArguments) {
    let output = stringToFormat;
    for(let formatArg in formattingArguments) {
        output = output.replace('{' + formatArg + '}', formattingArguments[formatArg]);
    }
    return output;
}

function castToStringList(values) {
    let result = [];
    for(let value in values) {
        result.push('' + value);
    }
    return result;
}

const EVENT_URL = '/services/data/v48.0/apexrest/narrate_EventREST';

const LIST_COLUMNS = [
    {
        type: "text",
        fieldName: "narrate_Context__c",
        label: "Context",
        initialWidth: 200
    },
    {
        type: "text",
        fieldName: "narrate_Level__c",
        label: "Level",
        initialWidth: 100
    },
    {
        type: "text",
        fieldName: "narrate_Class__c",
        label: "Class",
        initialWidth: 200
    },
    {
        type: "text",
        fieldName: "narrate_Method__c",
        label: "Method",
        initialWidth: 200
    },
    {
        type: "text",
        fieldName: "narrate_Message__c",
        label: "Message"
    },
];

export { LIST_COLUMNS, validRegex, logMatchesFilter, publishEvent, castToStringList, formatString}
