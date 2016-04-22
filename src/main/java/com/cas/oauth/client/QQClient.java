package com.cas.oauth.client;

import com.fasterxml.jackson.databind.JsonNode;
import org.pac4j.core.context.WebContext;
import org.pac4j.oauth.client.BaseOAuth20Client;
import org.pac4j.oauth.profile.JsonHelper;
import org.scribe.model.OAuthConfig;
import org.scribe.model.SignatureType;
import org.scribe.oauth.ExtendedOAuth20ServiceImpl;
/**
 * Title:
 * Company:
 * Copyright: Copyright (c) 2012
 * Description:
 * <Class Description >
 *
 * @author Andre.Qin created at 上午9:14 14-7-1
 */

public class QQClient extends BaseOAuth20Client<QQProfile> {
  protected QQScope scope = QQScope.get_user_info;
  protected String scopeValue ="get_user_info,get_other_info,add_t,add_share";

  public QQClient()
  {
  }

  public QQClient(String key, String secret)
  {
    setKey(key);
    setSecret(secret);
  }

  protected QQClient newClient()
  {
    QQClient newClient = new QQClient();
    newClient.setScope(this.scope);
    return newClient;
  }

  protected void internalInit()
  {
    super.internalInit();
    this.service = new ExtendedOAuth20ServiceImpl(new QQApi(), new OAuthConfig(this.key, this.secret, this.callbackUrl, SignatureType.Header, this.scopeValue, null), this.connectTimeout, this.readTimeout, this.proxyHost, this.proxyPort);
  }

  protected String getProfileUrl()
  {
    return "https://graph.qq.com/user/get_user_info";
  }

  protected QQProfile extractUserProfile(String body)
  {
    QQProfile profile = new QQProfile();
    JsonNode json = JsonHelper.getFirstNode(body);
    if (json != null) {
      profile.setId(JsonHelper.get(json, "id"));
      //for (String attribute : OAuthAttributesDefinitions.google2Definition.getPrincipalAttributes()) {
      //  profile.addAttribute(attribute, JsonHelper.get(json, attribute));
      //}
    }
    return profile;
  }

  public QQScope getScope() {
    return this.scope;
  }

  public void setScope(QQScope scope) {
    this.scope = scope;
  }

  protected boolean requiresStateParameter()
  {
    return false;
  }

  protected boolean hasBeenCancelled(WebContext context)
  {
    return false;
  }

  public static enum QQScope
  {
    get_user_info,
    get_simple_userinfo,
  }
}
