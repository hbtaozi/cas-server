package com.cas.oauth.client;

import org.scribe.builder.api.DefaultApi10a;
import org.scribe.builder.api.DefaultApi20;
import org.scribe.extractors.AccessTokenExtractor;
import org.scribe.model.OAuthConfig;
import org.scribe.model.Token;
import org.scribe.model.Verb;
import org.scribe.utils.OAuthEncoder;

/**
 * Title:
 * Company:
 * Copyright: Copyright (c) 2012
 * Description:
 * <Class Description >
 *
 * @author Andre.Qin created at 上午9:23 14-7-1
 */

public class QQApi extends DefaultApi20 {
  public String getAuthorizationUrl(OAuthConfig config)
  {
    return String.format("https://graph.qq.com/oauth2.0/authorize?client_id=%s&redirect_uri=%s&scope=%s&response_type=code",
            new Object[] { config.getApiKey(), OAuthEncoder.encode(config.getCallback()), OAuthEncoder.encode(config.getScope()) });
  }

  public String getAccessTokenEndpoint()
  {
    return "https://graph.qq.com/oauth2.0/token";
  }

  public Verb getAccessTokenVerb()
  {
    return Verb.POST;
  }

  //public AccessTokenExtractor getAccessTokenExtractor()
  //{
  //  return new QQJsonExtractor();
  //}
}
