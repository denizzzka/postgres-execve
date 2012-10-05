CREATE FUNCTION exec(cmd bytea[], _stdin bytea, _log boolean) RETURNS bytea[]
    LANGUAGE plpythonu COST 1000
    AS $$
from subprocess import Popen, PIPE

try:
    p = Popen( cmd, stdin=PIPE, stdout=PIPE, stderr=PIPE )
    res = p.communicate( _stdin )

except Exception, e:
    plpy.log( "[exec] %s\n" % ( e,) )
    raise

if _log:
    plpy.log( cmd, res )

if p.returncode != 0:
    plpy.log( 'ERROR' + ('' if _log else ': ' + res[1]) + ', errcode: ' + str( p.returncode ) )
    raise RuntimeError( p.returncode )

return res
$$;


COMMENT ON FUNCTION exec(cmd bytea[], _stdin bytea, _log boolean) IS 'If _log is true all call will be recorded into postgresql server log
On failure log will be recorded in any case.';
