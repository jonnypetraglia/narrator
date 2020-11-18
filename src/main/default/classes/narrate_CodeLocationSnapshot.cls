// This class is almost a copy+paste from apex-unified-logging, which is awesome and great!

public class narrate_CodeLocationSnapshot {

    public static narrate_CodeLocationSnapshot newInstanceForClass(String enclosingClassName) {
        return new narrate_CodeLocationSnapshot(enclosingClassName);
    }

    private narrate_CodeLocationSnapshot(String enclosingClassName) {
        this.enclosingClassName = enclosingClassName;
    }

    public class Snapshot {
        public String theClass, theMethod;
        public Integer theLine;
    }

    public Snapshot snap() {
        return getSnapshotFromStacktrace((new DmlException('FakeException')).getStackTraceString().split('\n'));
    }

    public Snapshot snap(Exception traceableException) {
        List<String> stackTrace = traceableException.getStackTraceString().split('\n');
        return extractSnapFromStacktraceLine(stackTrace.get(0));
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

    //// Private

    private Snapshot getSnapshotFromStacktrace(List<String> stacktrace) {
        Snapshot result = stacktrace.isEmpty() ? new Snapshot() : extractSnapFromStacktraceLine(stacktrace[0]);
        while(stacktrace.size() > 0 && result.theClass != enclosingClassName) {
            stacktrace.remove(0);
            result = stacktrace.isEmpty() ? new Snapshot() : extractSnapFromStacktraceLine(stacktrace[0]);
        }
        while(stacktrace.size() > 0 && extractSnapFromStacktraceLine(stacktrace[0]).theClass == enclosingClassName) {
            stacktrace.remove(0);
            result = stacktrace.isEmpty() ? new Snapshot() : extractSnapFromStacktraceLine(stacktrace[0]);
        }
        return result;
    }

    private String enclosingClassName;
    private final String THIS_CLASS_NAME = narrate_CodeLocationSnapshot.class.getName();
    
    private static final Pattern STACK_LINE = Pattern.compile('^(?:Class\\.)?([^.]+)\\.?([^\\.\\:]+)?[\\.\\:]?([^\\.\\:]*): line (\\d+), column (\\d+)$');
    private static final String ORG_NAMESPACE = [SELECT NamespacePrefix FROM Organization].NamespacePrefix;

    private static String prettyMethod(String method) {
        String result = (method == null) ? 'anonymous' : method;
        return (result.contains('init')) ? 'constructor' : result;
    }
}
