package root.ast.expressions;

import root.LocalizedToken;
import root.Token;

public class IdentifierExpression extends Expression {

    private String value;

    public IdentifierExpression(LocalizedToken token, String value) {
        this.token = token;
        this.value = value;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    @Override
    public String toString() {
        return value;
    }
}
