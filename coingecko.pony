use "collections"
use "net/http"
use "json"

actor Main
  new create(env: Env) =>
    let url = "https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=usd"
    HTTPClient(env.root as AmbientAuth).get(url, CryptoHandler)

class CryptoHandler is HTTPHandler
  fun ref apply(response: HTTPResponse ref) =>
    try
      let json = JsonDoc.parse(String.from_array(response.body))?.data as JsonObject
      let btc = json.data("bitcoin") as JsonObject
      let usd = btc.data("usd") as JsonNumber
      @printf[I32]("BTC narxi: $%.2f\n".cstring(), usd.f64())
    else
      @printf[I32]("Xatolik\n".cstring())
    end
