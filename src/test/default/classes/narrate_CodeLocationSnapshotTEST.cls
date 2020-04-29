@isTest
public with sharing class narrate_CodeLocationSnapshotTEST {

    @isTest
    private static void snapClass() {
        narrate_CodeLocationSnapshot.Snapshot snappy = narrate_CodeLocationSnapshot.snap();
        System.assertEquals('narrate_CodeLocationSnapshotTEST', snappy.theClass); // dude how meta
        System.assertEquals('snapClass', snappy.theMethod); // is this
    }

    @isTest
    private static void snapError() {
        narrate_CodeLocationSnapshot.Snapshot snappy = narrate_CodeLocationSnapshot.snap(new DmlException());
        System.assertEquals('narrate_CodeLocationSnapshotTEST', snappy.theClass); // dude how meta
        System.assertEquals('snapError', snappy.theMethod); // is this
    }
}
