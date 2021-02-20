{ ... }:

{
  krb5 = {
    enable = true;
    libdefaults.default_realm = "ARTEM.IST";
    domain_realm = {
      "artem.ist" = "ARTEM.IST";
      ".artem.ist" = "ARTEM.IST";
    };

    # Get everything else from DNS
    realms."ARTEM.IST".admin_server = "manehattan.artem.ist";
  };
}
