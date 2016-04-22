package com.cas.authentication;

import org.jasig.cas.authentication.Credential;
import org.jasig.cas.authentication.UsernamePasswordCredential;
import org.jasig.cas.integration.restlet.TicketResource;
import org.restlet.data.Form;
import org.springframework.web.bind.support.WebRequestDataBinder;
import org.springframework.web.context.request.WebRequest;

/**
 * Title:
 * Company:
 * Copyright: Copyright (c) 2012
 * Description:
 * <Class Description >
 *
 * @author Andre.Qin created at 15:56 2014/7/3
 */

public class ExtTicketResource extends TicketResource {
    protected Credential obtainCredentials() {
            final ExtUsernamePasswordCredential c = new ExtUsernamePasswordCredential();
            final WebRequestDataBinder binder = new WebRequestDataBinder(c);
            final RestletWebRequest webRequest = new RestletWebRequest(getRequest());

            //super.logFormRequest(new Form(getRequest().getEntity()));
            binder.bind(webRequest);

            return c;
        }
}
