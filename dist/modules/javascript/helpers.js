export function getDefaultHeaders() {
  return {
    "Content-Type": "application/json",
    "Accept": "application/json",
    "X-CSRF-Token": getCsrfToken()
  };
}
export function getCsrfToken() {
  return document.head.querySelector("meta[name='csrf-token']").content;
}
