public interface narrate_IFilterLogic {
    void setWhatToCompareTo(String comparison);
    void setLogic(String comparison);
    boolean evaluate(SObject compareTo);
}
