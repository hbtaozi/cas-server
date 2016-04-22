package com.cas.authentication.actions;

import com.cas.authentication.CasConstants;
import org.springframework.binding.message.MessageBuilder;
import org.springframework.binding.message.MessageContext;
import org.springframework.webflow.execution.Event;
import org.springframework.webflow.execution.RequestContext;


/**
 * Title:
 * Company:
 * Copyright: Copyright (c) 2012
 * Description:
 * <Class Description >
 *
 * @author Andre.Qin created at 11:21 2015/6/26
 */

public class ValidateAuthCodeAction {
    /** Error result. */
    public static final String CODE_VALIDATE_ERROR = "authCodeValidateFailed";
    public static final String CODE_VALIDATE_SUCCESS = "authCodeValidateSuccess";

    public final Event validate(final RequestContext context,
            final MessageContext messageContext) throws Exception {

        String code=context.getRequestParameters().get(CasConstants.AUTH_CODE_FIELD_NAME);
        String generateCode=(String)context.getExternalContext().getSessionMap().get(CasConstants.AUTH_CODE_SESSION_KEY);

        //remove the validate code from the request
       context.getExternalContext().getSessionMap().remove(CasConstants.AUTH_CODE_SESSION_KEY);

        //validate the code
        if(generateCode != null && !generateCode.equalsIgnoreCase(code))
        {
           messageContext.addMessage(new MessageBuilder().error().code("error.invalid.authcode").build());
           return new Event(this, CODE_VALIDATE_ERROR);
        }

         return new Event(this, CODE_VALIDATE_SUCCESS);
    }

}
