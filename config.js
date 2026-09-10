/* Zugangsdaten für die Synchronisierung.
   Beide Werte sind ausdrücklich für den Einsatz im Browser gedacht und dürfen
   öffentlich sichtbar sein – der Schutz der Daten kommt aus Row Level Security
   in der Datenbank, nicht aus der Geheimhaltung dieses Schlüssels.
   NIEMALS den service_role-Schlüssel hier eintragen: der umgeht RLS. */
window.WS_CONFIG = {
  supabaseUrl: "",      // z. B. https://abcdefghijkl.supabase.co
  supabaseAnonKey: ""   // der "anon public" bzw. "publishable" Schlüssel
};
