// This class is almost a copy+paste from apex-unified-logging, which is awesome and great!

public class narrate_CodeLocationSnapshot {

    public narrate_CodeLocationSnapshot() {
        Exception e = new DmlException();
        System.debug('aw yeah');
        System.debug(e.getStackTraceString().split('\n'));
    }

    public class Snapshot {
        public String theClass, theMethod;
        public Integer theLine;
    }

    public static Snapshot snap() {
        return snap(null);
    }

    public static Snapshot snap(Exception traceableException) {
        if(traceableException == null) {
            traceableException = new DmlException();
        }
        return findEndOfInheritence(removeLinesOfNarrators(removeLinesByThisClass(traceableException.getStackTraceString().split('\n'))));
    }

    public static Snapshot extractSnapFromStacktraceLine(String line) {
        Snapshot snap = new Snapshot();
        Matcher matcher = STACK_LINE.matcher(line);
        if(!matcher.find()) {
            return snap;
        }
        String className;
        Boolean hasNamespace = String.isNotBlank(matcher.group(3));
        String methodName;
        if(hasNamespace) {
            snap.theClass = (matcher.group(1).equals(ORG_NAMESPACE)) ? matcher.group(2) : matcher.group(1) + '.' + matcher.group(2);
            snap.theMethod = prettyMethod(matcher.group(3));
        } else {
            snap.theClass = matcher.group(1);
            snap.theMethod = prettyMethod(matcher.group(2));
        }
        snap.theLine = Integer.valueOf(matcher.group(4));
        return snap;
    }

    // Private

    private static List<String> removeLinesByThisClass(List<String> stacktrace) {
        while(stacktrace.size() > 0 && stacktrace[0].startsWith('Class.narrate_CodeLocationSnapshot.')) {
            System.debug('Removing lines by this class ' + stacktrace.get(0));
            stacktrace.remove(0);
        }
        return stacktrace;
    }

    private static List<String> removeLinesOfNarrators(List<String> stacktrace) {
        while(stacktrace.size() > 0) {
            System.debug('Removing lines of narrators ' + stacktrace.get(0));
            Snapshot snap = extractSnapFromStacktraceLine(stacktrace.get(0));
            try {
                narrate_INarrator what = (narrate_INarrator) Type.forName(snap.theClass).newInstance();
                stacktrace.remove(0);
            } catch(Exception error) {
                break;
            }
        }
        return stacktrace;
    }

    private static Snapshot findEndOfInheritence(List<String> stacktrace) {
        Snapshot snap = new Snapshot();
        Type lastType;
        while(stacktrace.size() > 0) {
            System.debug('finishing end of inheritance ' + stacktrace.get(0));
            Snapshot lineSnap = extractSnapFromStacktraceLine(stacktrace.get(0));
            Type lineType = Type.forName(lineSnap.theClass);
            if(lastType != null && !lastType.isAssignableFrom(lineType)) {
                snap = lineSnap;
                break;
            } else if(lastType == null) {
                lastType = lineType;
            }
            stacktrace.remove(0);
        }
        return snap;
    }
    
    private static final Pattern STACK_LINE = Pattern.compile('^(?:Class\\.)?([^.]+)\\.?([^\\.\\:]+)?[\\.\\:]?([^\\.\\:]*): line (\\d+), column (\\d+)$');
    private static final String ORG_NAMESPACE = [SELECT NamespacePrefix FROM Organization].NamespacePrefix;

    private static String prettyMethod(String method) {
        String result = (method == null) ? 'anonymous' : method;
        return (result.contains('init')) ? 'constructor' : result;
    }
}
