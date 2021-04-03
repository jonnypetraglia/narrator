# Narrator

The End-All-Be-All Logging framework to take care of all your Salesforce logging needs.
Use it as a great base that does all the boilerplate leaving you to focus on the important part.
Or use the `Narrate` Apex class in half a second to start logging now.

This is. The final word. In logging.

## Full List of Features:

This is all *in addition* to everything that's offered by [apex-unified-logging](https://github.com/rsoesemann/apex-unified-logging), which is what the project forked off of! *Major props for that lib!*

  - You only have to write ONE function to create a custom Logger!
  - Ships with a 'Log Entry' SObject, ready to hooked up & connected for persistent logging!
  - Built in Loggers supplied:
    - **Record Logger**
    - **Email Logger**
  - Schedulable auto-truncator Apex class configurable via Custom Settings!
  - Converted Aura components from apex-unified-logging to LWC!
  - A live Logging Monitor Lightning Web Component (and Flexipage!) that lets you see _all_ (or filtered) events _in real time_
  - Have fine-grained control what logs you want and what logger to use via **Custom Metadata** without ever having to change code. Add complex filters through a dead simple front-end interface. Turn them on, turn them off, make them expire. Be free.
  - @InvocableMethod!
  - @AuraEnabled getLogEntries!
  - Logs are grouped by Execution Context (and allows you to give a custom message to each as well!)
  - Gives you a lot of Apex goodies!
    - A Log Creator object!
    - A Code Location object! Get the exact place in code your log with the call of a function down to class, method, and line!
    - A Simple Filter Logic object!



## Setup

Narrator is designed to be extremely customizable but also extremely simple to get going. To turn it on and have every logging statement logged to an SObject record (`narrate_LogEntry__c`), just create a NarratorConfig hierarchical Custom Setting with "Active" checked. _That's literally it. Go start logging._


The heart of Narrator is the `Narrate` class that gives you a sane set of functions to do logging. It uses the highly granular LoggingSetting Custom Metadata, but an "All" Custom Metadata is included & enabled by default.

`Narrate` is created in such a way that it can be used out of the box or extended. Why extend? Several reasons.

Because you're going to be using it everywhere, you should get the choice of the class name you use!

```apex
public class Log extends Narrate {}
// Or maybe
public class Logger extends Narrate {}
// Or even
public class SimonSays extends Narrate {}
```

You can also add custom functions that build on the basic `Narrate` functions, For example:

```apex
public class Log extends Narrate {
  // Add your own functions to use your own logging levels!
  public static void goat(Goat aGoat){
    log('UserIsAGoat', aGoat.bahhh());
  }

  // Create functions based on your Exception classes for your own formatting
  public static void except(MyCustomException ohno) {
    String formattedExceptionString = ohno.formatMyOwnPrettyWay();
    log(EXCEPT, formattedExceptionString);
  }
}
```

### Alternative setup: ProcessBuilder/Flow

Alternatively, both included Logger implementations (RecordLogger and EmailLogger) implement @InvocableMethod, so you can make a ProcessBuilder or Flow and call it and boom, you're logging. Turn the Process or Flow on and off at your leisure.


## Sample usage

Below uses `Log` as an extension of `Narrate`:

```apex
  Log.debug('How {0} is this?', 'amazing');
  Log.debug('Just pass in {0} or {1} or {2} or {3} and it is all converted to a single string for you', new Object[] { 42, new Account(), new SomeCustomClass(), 'whatever you want'})
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

## Configuration

### Custom Settings

While the Custom Metadata is used to supply filters for what `LogEvent__e`s received and how to process them, the Custom Settings contains hierarchical settings for the Narrator package as a whole.

  - `Enabled` = If unchecked, all calls to `Narrate` logging functions will instead simply output to `System.debug`.
  - `EnabledTests` = If checked, Narrator will actually emit Platform EVents during test execution.
  - `AutoTruncateDays` = Only `LogEntry__c` records that were created in this number of days will be kept when `LogEntryTruncator` is run. The default is no limit.
  - `AutoTruncateMax` = The maximum number of `LogEntry__c` records to keep when `LogEntryTruncator` is run. The default is `10000`.


### Custom Metadata

Custom Metadata uses [Dependency Injection](https://en.wikipedia.org/wiki/Dependency_injection) (DI) to allow you to specify different `ILogger` implementations to handle the `LogEvent__e` and `IFilterLogic` implementations to evaluate the logic supplied for the setting against the `LogEvent__e`s received.

  - `Active` = Unchecked means this will be ignored by Narrator.
  - `Logic` = A string to be passed to the FilterLogic that will evaluate against the `LogEvent__e` that has been emitted; format is entirely dependent on the `IFilterLogic` class that is supplied. See __"Supplied FilterLogics" section__ for the included implementations & their expected logic formats.
  - `FilterLogic` = The name of the `IFilterLogic` implementation to evaluate the above supplied logic
  - `Loggers` = A list of comma- or semicolon-delimited `ILogger` implementations to pass the `LogEvent__e`s to that match the evaluated logic



## Dependency Injection Interfaces & Implementations

### Sample Custom Logger

If if you want to create your own Logger from scratch, it's *one* method to override:

```apex
public class ShoutingLogger implements narrate_ILogger {
    // Highly highly highly recommend that this function swallows all errors. Otherwise a bug in your logging framework could break your production code, which would REALLY suck.
    void log(List<narrate_LogEvent__e> data) {
      for(narrate_LogEvent__e datum : data){
        System.debug(datum.Message__c.toUppercase());
      }
    }
}
```

### Sample FilterLogic

IFilterLogic is a very very simple interface designed to (a) take a String and parse in some way as logic and (b) evaluate said logic against an SObject. How the String should be formatted to be valid logic is entirely up to you.

```apex
public class NameFilterLogic implements narrate_IFilterLogic {
    String myName;
    void setLogic(String comparison){
      myName = comparison;
    }
    boolean evaluate(SObject compareTo){
      return compareTo.isSet('Name') && compareTo.get('Name') == myName;
    }
}
```

### Supplied FilterLogics

#### SimpleFilterLogic

`SimpleFilterLogic` takes in a _set of tokens formatted as a JSON array of strings_ that allows for **one** criteria of comparison. If the JSON is malformed, a `FilterLogicException` is thrown.

The field name to be evaluated must _exactly_ match what is on the SObject (for the purposes of Narrator, `LogEvent__e`) and the value to be compared against **must be the same format of `.toString()` or casting to String for the field type**. Simply put: it is just as picky as parsing things as Apex, so DateTimes must be exactly correct and (at least for the moment) IDs must be the standard 13 or 15 digit ID of the referenced record.

Examples:

  - `['Level__c", '=', 'INFO']`
  - `['Message__c", 'CONTAINS', 'Banana']`
  - `['User__c", '!=', '00530000003xqAb']`


#### ComplexFilterLogic

`ComplexFilterLogic` is a that can use multiple `SimpleFilterLogic`s concatenated by operators `AND` and `OR` with the ability to use paren for order of operations. Technicalwise, it is a [finite-state machine](https://en.wikipedia.org/wiki/Finite-state_machine) with a very small vocabulary that expects you to have already parsed the tokens into an array stored as JSON. Just like a `SimpleFilterLogic`, if the JSON is malformed, a `FilterLogicException` is thrown.

Note that `ComplexFilterLogic` is a superset of `SimpleFilterLogic`, meaning that all logic that conforms to the latter is also valid for the former.

Example:

  - `['Level__c", '=', 'INFO', 'AND', 'Message__c', 'CONTAINS', 'Banana']`
  - `['(', 'Level__c', '=', 'WARNING', 'OR', 'Level', '=', 'ERROR', ')', 'AND', 'User__c', '!=', '00530000003xqAb']`


### Misc potentially useful info

How are you still reading this? Are you really that bored? Or do you just have a penchant for READMEs? Either way, kudos.

### CodeLocationSnapshot

Listen, I'm not gonna lie, I stole CodeLocationSnapshot almost verbatim from apex-unified-logging & just extracted it into its own class. It works by generating a stacktrace on the fly & then parsing it to determine where exactly in the code (Class, Method, Line) the wrapping function call was. That's all I'm gonna say about it.




## TODO & Ideas & Brainstorming

Obviously these need tickets eventually, but right now here's just where to dump accessible thoughts

  - Add "Logger Param" to LoggingSettings__mdt
    - Mostly for EmailLogger to specify recipients
    - This would mean we could ditch the CustomLabel (yay)
  - Desperately need Jest tests for LWC
  - Update Draw.io diagram, though hopefully it will get simplified enough to not be needed.