resource "google_compute_health_check" "default" {
  name = "http-health-check"

  http_health_check {
    port = 80
  }
}

resource "google_compute_backend_service" "default" {
  name            = "backend-service"
  protocol        = "HTTP"
  port_name       = "http"
  timeout_sec     = 10
  health_checks   = [google_compute_health_check.default.self_link]
  backend {
    group = google_compute_instance_group.instance_group.self_link
  }
}

resource "google_compute_url_map" "default" {
  name            = "url-map"
  default_service = google_compute_backend_service.default.self_link
}

resource "google_compute_target_http_proxy" "default" {
  name    = "http-proxy"
  url_map = google_compute_url_map.default.self_link
}

resource "google_compute_global_forwarding_rule" "default" {
  name       = "http-forwarding-rule"
  port_range = "80"
  target     = google_compute_target_http_proxy.default.self_link
}