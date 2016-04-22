package com.cas.authentication;

import org.jasig.cas.authentication.UsernamePasswordCredential;

/**
 * Title:
 * Company:
 * Copyright: Copyright (c) 2012
 * Description:
 * <Class Description >
 *
 * @author Andre.Qin created at 下午6:17 14-7-2
 */

public class ExtUsernamePasswordCredential extends UsernamePasswordCredential {
    String authWay;
    public String getAuthWay() {
        return authWay;
    }

    public void setAuthWay(String authWay) {
        this.authWay = authWay;
    }
}

