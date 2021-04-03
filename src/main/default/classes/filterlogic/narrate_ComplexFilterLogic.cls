public class narrate_ComplexFilterLogic implements narrate_IFilterLogic {
    @testVisible
    private enum Operator { OP_AND, OP_OR, OP_XOR }
    @testVisible
    private List<narrate_IFilterLogic> filterLogics = new List<narrate_IFilterLogic>();
    @testVisible
    private List<Operator> operators = new List<Operator>();
    public void setLogic(String filterLogic) {
        String[] parsedLogic = (String[])JSON.deserialize(filterLogic, String[].class);
        PeekIterator peekIterator = new PeekIterator(parsedLogic);
        parseToken(peekIterator);
        if(peekIterator.hasNext()){
            throw new narrate_FilterLogicParseException('Expected end of input, received: ' + peekIterator.next(), peekIterator.contentsAsString());
        }
    }

    @testVisible
    private PeekIterator parseToken(PeekIterator iter){
        String token = iter.peek();
        Boolean finished = false;
        //System.debug('WHAT');
        while(!finished){
            //System.debug('token=' + token);
            if(token == ')'){
                finished = true;
            }else if(token == '('){
                iter = parseNestedFilter(iter);
            }else if(token == 'AND' || token == 'OR'){
                iter = parseOperator(iter);
            }else{
                iter = parseExpression(iter);
            }
            if(iter.hasNext()){
                token = iter.peek();
            }else{
                finished = true;
            }
        }
        //System.debug(filterLogics);
        //System.debug(operators);
        if(operators.size() != (filterLogics.size()-1)){
            throw new narrate_FilterLogicParseException(iter.contentsAsString(), 'Bad logic format: ' + filterLogics.size() + ' filters and ' + operators.size() + ' ops');
        }
        return iter;
    }
    @testVisible
    private PeekIterator parseNestedFilter(PeekIterator iter){
        //System.debug('HEEEEEEEEEEEEEEEEEERP');
        narrate_ComplexFilterLogic subLogic = new narrate_ComplexFilterLogic();
        iter = parseOpenParen(iter);
        //System.debug('done with parseOpenParen');
        iter = subLogic.parseToken(iter);
        //System.debug('So close');
        iter = parseCloseParen(iter);
        filterLogics.add(subLogic);
        return iter;
    }
    @testVisible
    private PeekIterator parseExpression(PeekIterator iter){
        // System.debug('Parsing Expression ' + iter);
        List<String> params = new List<String>();
        params.add(iter.next());
        params.add(iter.next());
        // System.debug('params ' + params);
        // System.debug('??????????????????? ' + narrate_SimpleFilterLogic.getNumberOfArgsForLogic(params.get(1)));
        for(Integer i=0; i<narrate_SimpleFilterLogic.getNumberOfArgsForLogic(params.get(1)); i++){
            params.add(iter.next());
        }
        // System.debug('Expression: ' + params);
        narrate_SimpleFilterLogic childFilter = new narrate_SimpleFilterLogic();
        childFilter.setLogic(JSON.serialize(params));
        filterLogics.add(childFilter);
        // System.debug('Finished parsing expression: ' + iter);
        return iter;
    }
    @testVisible
    private PeekIterator parseOperator(PeekIterator iter){
        //System.debug('Parsing op');
        String token = iter.next();
        if(token=='OR'){
            operators.add(Operator.OP_OR);
        }else if(token=='AND'){
            operators.add(Operator.OP_AND);
        }else if(token=='XOR'){
            operators.add(Operator.OP_XOR);
        }else{
            throw new narrate_FilterLogicParseException(iter.contentsAsString(), 'Unknown Operator:' + token);
        }
        return iter;
    }
    @testVisible
    private PeekIterator parseOpenParen(PeekIterator iter){
        //System.debug('Parsing (');
        if(iter.next()!='('){
            throw new narrate_FilterLogicParseException(iter.contentsAsString(), 'Expected to receive: (');
        }
        return iter;
    }
    @testVisible
    private PeekIterator parseCloseParen(PeekIterator iter){
        //System.debug('Parsing )');
        if(iter.next()!=')'){
            throw new narrate_FilterLogicParseException(iter.contentsAsString(), 'Expected to receive: )');
        }
        return iter;
    }
    public boolean evaluate(SObject compareTo) {
        Boolean result = true;
        if(filterLogics.size()>0){
            //System.debug('Evaluating Logic ' + operators + ' ' + filterLogics);
            Integer filterIndex = 0, opIndex = 0;
            result = filterLogics.get(filterIndex++).evaluate(compareTo);
            //System.debug((filterIndex-1) + ' => ' + result);
            while(filterIndex < filterLogics.size() && opIndex < operators.size()){
                //System.debug(filterLogics.get(filterIndex).toString());
                result = evaluate(result, operators.get(opIndex++), filterLogics.get(filterIndex++), compareTo);
                //System.debug((filterIndex-1) + ' => ' + operators.get(opIndex-1) + ' ' + result + ' - ' + filterLogics.get(filterIndex-1));
            }
        }
        return result;
    }
    private boolean evaluate(Boolean left, Operator op, narrate_IFilterLogic right, SObject compareTo){
        if(op==Operator.OP_AND){
            return left && right.evaluate(compareTo);
        }else if(op==Operator.OP_OR){
            return left || right.evaluate(compareTo);
        }else if(op==Operator.OP_XOR){
            boolean rightResult = right.evaluate(compareTo);
            return (left && !rightResult) || (!left && rightResult);
        }
        return false; //HOW WOULD THIS EVEN HAPPEN
    }
    @testVisible
    private class PeekIterator implements Iterator<String> {
        List<String> contents;
        Integer index = 0;
        public PeekIterator(List<String> contents){
            this.contents = contents;
        }
        public boolean hasNext(){
            return index < contents.size();
        }
        public String next(){
            if(!hasNext()){
                System.debug('no has next');
                throw new narrate_FilterLogicParseException('Unexpected end of input', contentsAsString());
            }
            return contents.get(index++);
        }
        public String peek(){
            if(!hasNext()){
                System.debug('no has next');
                throw new narrate_FilterLogicParseException('Unexpected end of input', contentsAsString());
            }
            return contents.get(index);
        }
        public String contentsAsString(){
            return String.valueOf(JSON.serialize(contents));
        }
    }

    override public String toString(){
        List<String> result = new List<String>();
        for(Integer i=0; i<filterLogics.size(); i++){
            result.add(filterLogics.get(i).toString());
            if(i<operators.size()){
                result.add(operators.get(i) == Operator.OP_OR ? 'OR' : 'AND');
            }
        }
        return String.join(result, ' ').trim();
    }

    public Boolean equals(Object compareToObj) {
        if(compareToObj === this){
            return true;
        }
        if(!(compareToObj instanceof narrate_ComplexFilterLogic)){
            return false;
        }
        narrate_ComplexFilterLogic compareTo = (narrate_ComplexFilterLogic)compareToObj;
        if(this.filterLogics.size() !=compareTo.filterLogics.size()){
            return false;
        }
        boolean isEqual = true;
        Integer i=0;
        while(isEqual && i<filterLogics.size()){
            isEqual = this.filterLogics[i] == compareTo.filterLogics[i];
            i+=1;
        }
        return isEqual;
    }
}