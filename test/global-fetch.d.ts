declare type GlobalFetch = {
  fetch: (url: RequestInfo, init?: RequestInit) => Promise<Response>;
};
