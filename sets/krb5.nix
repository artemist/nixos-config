{ ... }:

{
  krb5 = {
    enable = true;
    libdefaults.default_realm = "MANEHATTAN.ARTEM.IST";
    domain_realm = {
      "manehattan.artem.ist" = "MANEHATTAN.ARTEM.IST";
      ".manehattan.artem.ist" = "MANEHATTAN.ARTEM.IST";
    };
    realms."MANEHATTAN.ARTEM.IST" = {
      admin_server = "luna.manehattan.artem.ist";
      kdc = "luna.manehattan.artem.ist";
    };
  };
}
