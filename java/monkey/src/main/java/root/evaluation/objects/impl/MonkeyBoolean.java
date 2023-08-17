package root.evaluation.objects.impl;

import root.evaluation.objects.MonkeyObject;
import root.evaluation.objects.ObjectType;

public class MonkeyBoolean extends MonkeyObject<Boolean> {

    public static final MonkeyBoolean TRUE = new MonkeyBoolean(true);

    public static final MonkeyBoolean FALSE = new MonkeyBoolean(false);

    private MonkeyBoolean(boolean value) {
        super(ObjectType.BOOLEAN);
        setValue(value);
    }

    @Override
    public String inspect() {
        return String.valueOf(getValue());
    }
}
