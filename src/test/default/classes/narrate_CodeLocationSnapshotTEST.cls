@isTest
public with sharing class narrate_CodeLocationSnapshotTEST {

    @isTest
    private static void snapClass() {
        narrate_CodeLocationSnapshot.Snapshot snappy = (new narrate_CodeLocationSnapshot()).snap();
        System.assertEquals('narrate_CodeLocationSnapshotTEST', snappy.theClass); // dude how meta
        System.assertEquals('snapClass', snappy.theMethod); // is this
    }

    @isTest
    private static void snapError() {
        narrate_CodeLocationSnapshot.Snapshot snappy = (new narrate_CodeLocationSnapshot()).snap(new DmlException());
        System.assertEquals('narrate_CodeLocationSnapshotTEST', snappy.theClass); // dude how meta
        System.assertEquals('snapError', snappy.theMethod); // is this
    }

    @isTest
    private static void snapParentClass() {
        narrate_CodeLocationSnapshot.Snapshot snappy = (new NarrateParentEquivalent()).log();
        System.assertEquals('narrate_CodeLocationSnapshotTEST', snappy.theClass); // dude how meta
        System.assertEquals('snapParentClass', snappy.theMethod); // is this
    }

    @isTest
    private static void snapParentError() {
        narrate_CodeLocationSnapshot.Snapshot snappy = (new NarrateParentEquivalent()).error(new DmlException());
        System.assertEquals('narrate_CodeLocationSnapshotTEST', snappy.theClass); // dude how meta
        System.assertEquals('snapParentError', snappy.theMethod); // is this
    }

    private class NarrateParentEquivalent {
        public narrate_CodeLocationSnapshot.Snapshot log() {
            return (new NarrateEquivalent()).snapTest(new DmlException());
        }

        public  narrate_CodeLocationSnapshot.Snapshot error(Exception e) {
            return (new NarrateEquivalent()).snapTestError(e);
        }
    }

    private class NarrateEquivalent {
        public narrate_CodeLocationSnapshot.Snapshot snapTest(Exception e) {
            return (new narrate_CodeLocationSnapshot('narrate_CodeLocationSnapshotTEST.NarrateParentEquivalent')).snap(e);
        }

        public narrate_CodeLocationSnapshot.Snapshot snapTestError(Exception e) {
            return (new narrate_CodeLocationSnapshot('narrate_CodeLocationSnapshotTEST.NarrateParentEquivalent')).snap(e);
        }
    }
}
