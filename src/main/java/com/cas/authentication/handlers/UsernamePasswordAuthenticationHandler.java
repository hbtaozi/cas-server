package com.cas.authentication.handlers;

import com.cas.authentication.ExtUsernamePasswordCredential;
import com.framework.core.encryption.EncryptExtraObject;
import com.framework.core.encryption.EncryptService;
import org.jasig.cas.adaptors.jdbc.AbstractJdbcUsernamePasswordAuthenticationHandler;
import org.jasig.cas.authentication.Credential;
import org.jasig.cas.authentication.HandlerResult;
import org.jasig.cas.authentication.UsernamePasswordCredential;
import org.jasig.cas.authentication.principal.SimplePrincipal;
import org.springframework.dao.IncorrectResultSizeDataAccessException;
import org.springframework.util.Assert;

import java.security.GeneralSecurityException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class UsernamePasswordAuthenticationHandler extends AbstractJdbcUsernamePasswordAuthenticationHandler
{
  private String authWay;
  private String sql;
  private EncryptService encryptService;

  public String getAuthWay() {
      return authWay;
  }

  public void setAuthWay(String authWay) {
      this.authWay = authWay;
  }

    public EncryptService getEncryptService()
  {
    return this.encryptService;
  }

  public void setEncryptService(EncryptService encryptService) {
    this.encryptService = encryptService;
  }

  @Override
  public boolean supports(Credential credential)
  {
      ExtUsernamePasswordCredential crd = (ExtUsernamePasswordCredential)credential;
      if(crd.getAuthWay()!=null && this.getAuthWay() != null && this.getAuthWay().equalsIgnoreCase(crd.getAuthWay())
         || crd.getAuthWay() == null &&  this.getAuthWay() == null
         )
          return true;
      else
          return false;
  }

  @Override
  protected HandlerResult authenticateUsernamePasswordInternal(UsernamePasswordCredential credentials)
          throws GeneralSecurityException
  {

    String username = credentials.getUsername().toLowerCase();

    String password = credentials.getPassword();
    EncryptExtraObject eeo = new EncryptExtraObject();
    eeo.setLoginId(username);
    String encryptedPassword = this.encryptService.encrypt(password, eeo);

    try
    {
        String dbPassword = getJdbcTemplate().queryForObject(this.sql, new Object[] { username }, String.class);
        boolean isEqual = dbPassword.equals(encryptedPassword);
        if (isEqual)
        {
            Map<String,Object> attr = new HashMap<String,Object>(5);
            attr.put("authWay",this.authWay);
            SimplePrincipal simplePrincipal = new SimplePrincipal(credentials.getId(),attr);
            return createHandlerResult(credentials, simplePrincipal, null);
        }

        //更新登录信息
        //todo
    } catch (Exception e) {
        //e.printStackTrace();
    }

    //failed
    throw new GeneralSecurityException();
  }

  protected void initDao() throws Exception {
    Assert.notNull(this.sql, "the SQL statement cannot be null");
  }

  public void setSql(String sql) {
    this.sql = sql;
  }
}