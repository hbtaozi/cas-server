package com.cas.authentication;

import org.jasig.cas.authentication.Credential;
import org.jasig.cas.authentication.principal.Principal;
import org.jasig.cas.authentication.principal.PrincipalResolver;
import org.jasig.cas.authentication.principal.SimplePrincipal;

import java.util.HashMap;
import java.util.Map;

/**
 * Title:
 * Company:
 * Copyright: Copyright (c) 2012
 * Description:
 * <Class Description >
 *
 * @author Andre.Qin created at 17:18 2014/7/3
 */

public class ExtUsernamePasswordPrincipalResolver implements PrincipalResolver {
        public Principal resolve(final Credential credential) {
            Map attr = new HashMap();
                attr.put("authWay",((ExtUsernamePasswordCredential)credential).getAuthWay());
            return new SimplePrincipal(credential.getId(),attr);
        }
        public boolean supports(final Credential credential) {
            return credential.getId() != null;
        }
}
