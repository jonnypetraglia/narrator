public interface narrate_INarrator {
    void log(String level, String message, List<Object> values);
    void except(Exception error);
    void restRequest(RestRequest request);
    void restResponse(RestResponse request);
    void flush();
    String getContext();
    void setContext(String context);
}
