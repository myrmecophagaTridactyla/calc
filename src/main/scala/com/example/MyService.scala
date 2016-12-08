package com.example

import akka.actor.Actor
import spray.routing._
import spray.http._
import MediaTypes._
import java.io.File
import spray.http.HttpHeaders.RawHeader
import spray.json.DefaultJsonProtocol
import spray.httpx.SprayJsonSupport._
import com.novus.salat._
import com.novus.salat.global._
import scala.util.Properties._


object myCalcSumProtocol extends DefaultJsonProtocol  {
   implicit val calcSumFormat = jsonFormat3(calcSum.apply)
}

case class calcSum(sum1: Int, sum2: Int, result: Int)

// we don't implement our route structure directly in the service actor because
// we want to be able to test it independently, without having to spin up an actor
class MyServiceActor extends Actor with MyService {

  // the HttpService trait defines only one abstract member, which
  // connects the services environment to the enclosing actor or test
  def actorRefFactory = context

  // this actor only runs our route, but you could add
  // other things here, like request stream processing
  // or timeout handling
  def receive = runRoute(myRoute)
}


// this trait defines our service behavior independently from the service actor
trait MyService extends HttpService with DefaultJsonProtocol {

  val myRoute =
    pathPrefix("api" / "v1" / "sum") {
      import myCalcSumProtocol._
      get {
        respondWithMediaType(MediaTypes.`application/json`) { 
//         entity(as[calcSum]) { calcSum =>
//            complete(calcSum(calcSum.sum1, calcSum.sum2, calcSum.sum1 + calcSum.sum2))
            complete(calcSum(3, 4, 5))
          }
        }
      } 
      ~ post {
        entity(as[calcSum]) { calcSum =>
          complete(calcSum(3, 2, 5))
        }
      }
    }
}
