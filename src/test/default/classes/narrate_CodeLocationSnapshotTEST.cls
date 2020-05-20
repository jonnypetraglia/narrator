@isTest
public with sharing class narrate_CodeLocationSnapshotTEST {

    @isTest
    private static void snapWithEnclosingClass() {
        narrate_CodeLocationSnapshot.Snapshot snappy = (new ThisClassUsesSnapshot()).snapTest();
        System.assertEquals('narrate_CodeLocationSnapshotTEST', snappy.theClass); // dude how meta
        System.assertEquals('snapWithEnclosingClass', snappy.theMethod); // is this
        System.assertEquals(6, snappy.theLine);
    }

    @isTest
    private static void snapErrorWithEnclosingClass() {
        narrate_CodeLocationSnapshot.Snapshot snappy = (new ThisClassUsesSnapshot()).snapTestError(new DmlException());
        System.assertEquals('narrate_CodeLocationSnapshotTEST', snappy.theClass); // dude how meta
        System.assertEquals('snapErrorWithEnclosingClass', snappy.theMethod); // is this
        System.assertEquals(14, snappy.theLine);
    }

    @isTest
    private static void snapWithEnclosingClassExtended() {
        narrate_CodeLocationSnapshot.Snapshot snappy = (new ThisClassExtendsTheClassThatUsesSnapshot()).snapTest();
        System.assertEquals('narrate_CodeLocationSnapshotTEST', snappy.theClass); // dude how meta
        System.assertEquals('snapWithEnclosingClassExtended', snappy.theMethod); // is this
        System.assertEquals(22, snappy.theLine);
    }

    @isTest
    private static void snapErrorWithEnclosingClassExtended() {
        narrate_CodeLocationSnapshot.Snapshot snappy = (new ThisClassExtendsTheClassThatUsesSnapshot()).snapTestError(new DmlException());
        System.assertEquals('narrate_CodeLocationSnapshotTEST', snappy.theClass); // dude how meta
        System.assertEquals('snapErrorWithEnclosingClassExtended', snappy.theMethod); // is this
        System.assertEquals(30, snappy.theLine);
    }

    private class ThisClassExtendsTheClassThatUsesSnapshot extends ThisClassUsesSnapshot {
        public ThisClassExtendsTheClassThatUsesSnapshot() {
            snapshotter = narrate_CodeLocationSnapshot.newInstanceForClass('narrate_CodeLocationSnapshotTEST.ThisClassUsesSnapshot');
        }
    }

    private virtual class ThisClassUsesSnapshot {
        private narrate_CodeLocationSnapshot snapshotter;

        public ThisClassUsesSnapshot() {
            snapshotter = narrate_CodeLocationSnapshot.newInstanceForClass('narrate_CodeLocationSnapshotTEST.ThisClassUsesSnapshot');
        }
        public narrate_CodeLocationSnapshot.Snapshot snapTest() {
            return snapshotter.snap();
        }
        public narrate_CodeLocationSnapshot.Snapshot snapTestError(Exception e) {
            return snapshotter.snap(e);
        }
    }
}
