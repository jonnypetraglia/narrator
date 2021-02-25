# Narrator

The End-All-Be-All Logging framework to take care of all your logging needs.
Use it as a great base that does all the boilerplate leaving you to focus on the important part.
Or use the `Narrate` Apex class in half a second to start getting logging into your code in minutes.

This is. The final word. In logging.

### Sample usage

Because you're going to be using it everywhere, you should get the choice of the class name you use!

```apex
public class Log extends Narrate {}
// Or maybe
public class Logger extends Narrate {}
// Or even
public class SimonSays extends Narrate {}
```

DONE. Away we go:


```apex
  Log.start('YO WE LOGGING NOW'); // I can optionally give a context -a unique string-, or have one generated for me
  Log.debug('How {0} is this?', 'amazing');
  Log.debug('Just pass in {0} or {1} or {2} or {3} and it is all converted to a single string for you', new Object[] { 42, new Account(), new SomeDTOClass(), 'whatever you want'})
  Log.info('Now I am info');
  Log.fine('All the system levels are built right in!');
  Log.wtf('And more!');

  try {
    Integer theAnswerToLifeTheUniverseAndEverything = 42 / 0;
  } catch(Exception error) {
    Log.error('Woah, an exception! I have a method specifically for that to make it all pretty and such!');
    Log.except(error);
  }
```


### Sample Custom Logger

If if you want to create your own Logger from scratch, it's *one* method to override:

```apex
public class ShoutingLogger implements narrate_ILogger {
    // Highly highly highly recommend that this function swallows all errors. Otherwise a bug in your logging framework could break your production code, which would REALLY suck.
    void log(narrate_LogEvent__e data) {
      System.debug(data.Message__c.toUppercase());
    }
}
```

### Full List of Features:

This is all *in addition* to everything that's offered by [apex-unified-logging](https://github.com/rsoesemann/apex-unified-logging), which is what the project forked off of! *Major props for that lib!*

  - You only have to write ONE function to create a Logger!
  - Ships with a 'Log Entry' SObject, ready to hooked up & connected for persistent logging!
  - Built in Loggers supplied:
    - **Record Logger**
    - **Email Logger**
  - Schedulable auto-truncator Apex class configurable via Custom Settings!
  - A live Logging Monitor Lightning Web Component (and Flexipage!) that lets you see _all_ (or filtered) events _in real time_
  - Have fine-grained control what logs you want and what logger to use via **Custom Metadata** without ever having to change code. Add complex filters through a dead simple front-end interface. Turn them on, turn them off, make them expire. Be free.
  - @InvocableMethod!
  - @AuraEnabled getLogEntries!
  - Logs are grouped by Execution Context (and allows you to give a custom message to each as well!)
  - Gives you a lot of Apex goodies!
    - A Log Creator object!
    - A Code Location object! Get the exact place in code your log with the call of a function down to class, method, and line!
    - A Simple Filter Logic object!





### Using Custom Metadata

// TODO
// Set filter
// Can set user
// Select a Logger via specifying a class name


### How to use the Filter

IFilterLogic is an interface designed to take a list of strings describing what comparisons to perform on an SObject. This interface expects the input to be a very particular format, but ultimately its job is to return a Boolean as to i the record matches or not.

```apex
new String[] {'Name', '=', 'Robert Paulson'};
new String[] {'Company', 'IS NOT NULL'};
new String[] {'CreatedDate', 'IS TODAY'};
```
The supplied SimpleFilterLogic allows for **one** set of criteria, like above. Additionally, a list of the allowed operations -like "=", "IS NOT NULL", and "IS TODAY" above- for SimpleFilterLogic is available for viewing in the class itself.

A more advanced FilterLogic class may be able to take logic like:

```apex
new String[] {'Name', '=', 'Robert Paulson', 'AND', 'Company', 'CONTAINS', 'soap'};
new String[] {'(', 'FirstName', '=', 'Robert', 'OR', 'FirstName', '=', 'Rob', ')', 'AND', 'LastName', '=', 'Paulson'};
```

For the implementation of such logic, as $200 textbooks would say: "The exercise is left to the reader".

#### In Config

The Logging Settings Custom Metadata expects the Logic field to be a **JSON Array** of Strings:

```apex
setting.Logic__c = '["Email", "DOES NOT CONTAIN", "avocado"]';
```


Ultimately, you as an admin are responsible for (a) ensuring the field is JSON parsable, and (b) matches with the available input for the FilterLogic class you use.