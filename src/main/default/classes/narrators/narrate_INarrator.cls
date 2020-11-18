public interface narrate_INarrator {
    void log(String level, String message, List<Object> values);
    void except(Exception error);
    void restRequest(RestRequest request);
    void restResponse(RestResponse request);
    void httpRequest(HttpRequest request);
    void httpResponse(HttpResponse request);
    String getContext();
    void setContext(String context);
    void setCodeLocationSnapshot(narrate_CodeLocationSnapshot snap);
}
