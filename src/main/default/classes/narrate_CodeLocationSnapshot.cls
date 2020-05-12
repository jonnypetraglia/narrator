// This class is almost a copy+paste from apex-unified-logging, which is awesome and great!

public class narrate_CodeLocationSnapshot {

    public narrate_CodeLocationSnapshot(String parentType) {
        this.parentType = parentType;
    }

    public narrate_CodeLocationSnapshot() {
        this.parentType = getClassNameOfImmediatelyEnclosingClass();
        System.debug('AUTO ' + this.parentType);
    }

    public class Snapshot {
        public String theClass, theMethod;
        public Integer theLine;
    }

    public Snapshot snap() {
        return snap(null);
    }

    public Snapshot snap(Exception traceableException) {
        if(traceableException == null) {
            traceableException = new DmlException();
        }
        List<String> filteredStackTrace = removeLinesUntilParentClass(traceableException.getStackTraceString().split('\n'));
        return filteredStackTrace.size()>0 ? extractSnapFromStacktraceLine(filteredStackTrace.get(0)) : new Snapshot();
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

    private List<String> removeLinesUntilParentClass(List<String> stacktrace) {
        System.debug('Removing lines by parent class ' + parentType + ': ' + extractSnapFromStacktraceLine(stacktrace[0]).theClass);
        while(stacktrace.size() > 0 && extractSnapFromStacktraceLine(stacktrace[0]).theClass != parentType) {
            System.debug('Removing lines by parent class ' + parentType + ': ' + extractSnapFromStacktraceLine(stacktrace[0]).theClass);
            stacktrace.remove(0);
        }
        while(stacktrace.size() > 0 && extractSnapFromStacktraceLine(stacktrace[0]).theClass == parentType) {
            System.debug('Removing lines by parent class ' + parentType + ': ' + extractSnapFromStacktraceLine(stacktrace[0]).theClass);
            stacktrace.remove(0);
        }
        return stacktrace;
    }

    private String getClassNameOfImmediatelyEnclosingClass() {
        return extractSnapFromStacktraceLine(((new DmlException()).getStackTraceString().split('\n').get(1))).theClass;
    }

    private String parentType;
    
    private static final Pattern STACK_LINE = Pattern.compile('^(?:Class\\.)?([^.]+)\\.?([^\\.\\:]+)?[\\.\\:]?([^\\.\\:]*): line (\\d+), column (\\d+)$');
    private static final String ORG_NAMESPACE = [SELECT NamespacePrefix FROM Organization].NamespacePrefix;

    private static String prettyMethod(String method) {
        String result = (method == null) ? 'anonymous' : method;
        return (result.contains('init')) ? 'constructor' : result;
    }
}
