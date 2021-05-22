let CURRENT_ID = 0

function CreateBlockIdentity(peer, callback) {
  const byte = []
  return {
    block: peer,
    cb: callback,
    id: GetNextID(true),
    ... byte
  };
}

function GetNextID(add) {
  if (!(add === true)) { CURRENT_ID = CURRENT_ID + 1}
  return {
    next: CURRENT_ID + 1
  };
}
