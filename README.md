# Narrator

The End-All-Be-All Logging framework to take care of all your logging needs.
Use it as a great base that does all the boilerplate leaving you to focus on the important part.
Or use the `Narrate` Apex class in half a second to start getting logging into your code in minutes.

This is. The final word. In logging.

### Sample usage

Because you're going to be using it everywhere, you should get the choice of the class name you use!

```java
public class Log extends Narrate {}
```

DONE. You now have a fully functional logging class named `Log`. Away we go:


```java
  Log.debug('Yo, we logging now!');
  Log.debug('How {0} is this?', new String[] { 'amazing' });
  Log.info('Now im info');
  Log.fine('All the system levels are built right in!');
  Log.wtf('And more!');
  Log.log('wack', 'And you can make your own!!!');

  Log.start('I can optionally give a context -a unique string-, or have one generated for me');
  Log.setBufferSizeLimit(3); // Maybe now I feel like having a buffer
  Log.debug('Now I continue as normal');
  Log.warn('Then after the third log,');
  Log.wtf('It gets flushed for you!') // Flushes afer executing this statement

  Log.debug('Or I can do it manually');
  Log.flush(); // flush at any time!
  
  try {
    Integer theAnswerToLifeTheUniverseAndEverything = 42 / 0;
  } catch(Exception error) {
    Log.error('Woah, an exception! I have a method specifically for that to make it all pretty and such!');
    Log.except(error);
  }

  Log.debug('Thanks for chatting with me!');
  Log.finish(); // This is just an alias for flush but it really gives some nice closure, doesn't it?
```


### Sample Custom Logger

SimpleLogger is a supplied virtual class that makes it stupid simple to set up your own logger by overriding *one* function.

```java
public class ExcitableLogger extends narrate_SimpleLogger {
    public Integer processEvents() {
      for(narrate_LogEvent___e logEvent : buffer) {
        System.debug(buffer.narrate_Message__c + '!!!');
      }
      return buffer.size();
    }
}
```

If if you want to create your own Logger from scratch, it's *two* methods to override:

```java
public class ShoutingLogger implements narrate_ILogger {
    void log(narrate_LogEvent__e data) {
      System.debug(data.narrate_Message__c.toUppercase());
    }
    void flush() {
      System.debug('WE\'RE FLUSHING BUT I DON\'T KNOW WHY I\'M TELLING YOU THAT');
    }
}
```


### Sample Narrator

What's a narrator? Well, it's simple: a Narrator says the things, a Logger logs the things.

```java
public class narrate_SystemDebugNarrator implements narrate_INarrator {
    public void log(String level, String message, List<Object> values) {
        System.debug('Hear ye, hear ye, I doth proclaim, at a level of ' + level + ', ' + message + ' is wack');
    }
    public void except(Exception error) {
        System.debug('Oh heelllllll no, you did not just throw a ' + error.getTypeName());
    }
    public void flush() {
        // Nothing to do
    }
    void restRequest(RestRequest request) {
      System.debug('REQUESTING FROM URI: ' + request.requestURI);
    }
    void restResponse(RestResponse response) {
      System.debug('RESPONSE STATUS CODE: ' + response.statusCode);
    }
    public String getContext() {
        return context;
    }
    public void setContext(String context) {
        this.context = context;
    }
    //// Private
    private String context;
```


### Full List of Features:

This is all *in addition* to everything that's offered by [apex-unified-logging](https://github.com/rsoesemann/apex-unified-logging), which is what the project forked off of! *Major props for that lib!*

  - You only have to write ONE function to create a Logger!
  - Built in Loggers supplied:
    - **Record Logger**
    - **Email Logger**
    - **Platform Event Logger**
    - **Instant Notification Logger** _(WIP)_
  - A live Logging Monitor Lightning Web Component (and Flexipage!) that lets you see _all_ (or filtered) events _in real time_
  - If you want something small and simple, clone the provided ProcessBuilder and just customize the If criteria to your liking! Then you can toggle them on and off at will! //TODO Need to redo PB
  - If you want more fine-grained control, control what logs you want and what logger to use via **Custom Metadata** without ever having to change code. Add complex filters through a dead simple front-end interface. Turn them on, turn them off, make them expire. Be free.
  - @InvocableMethod!
  - @AuraEnabled getLogEntries!
  - Ships with a 'Log Entry' SObject, ready to hooked up & connected for persistent logging!
  - Logs are grouped by Execution Context (and allows you to give a custom message to each as well!)
  - Gives you a lot of Apex goodies!
    - A Log Creator object!
    - A SimpleLogger abstract class that makes it so easy, it takes as little as extending the class with _1 function_ to create your own Logger!
    - 4 example loggers that are fully functional and fully extendable! (Platform Event, Email, Instant Notification, Console)
    - A Stack Trace object! Get the exact place in code your log with the call of a function!
    - A Simple Filter Logic object!
    - *F U N* utilities! for! logging!





## Now we get to the nerdy stuff

// TODO

### Using Custom Metadata

// TODO
// Set filter
// Can set user
// Select a Logger via specifying a class name


### How to use the Filter

// TODO

#### In Code

// TODO

#### In Config

// TODO

### Extending SimpleLoger

// TODO

### Implementing your own Logger

// TODO

### Implementing your own Narrator

// TODO

### Implementing your own Filter

// TODO