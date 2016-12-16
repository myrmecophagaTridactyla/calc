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


object myCalcProtocol extends DefaultJsonProtocol  {
   implicit val calcFormat = jsonFormat3(calc.apply)
}

case class calc(num1: Float, num2: Float, result: Float)

// we don't implement our route structure directly in the service actor because
// we want to be able to test it independently, without having to spin up an actor
class MyServiceActor extends Actor with MyServiceRoute with MyStaticRoute {

  // the HttpService trait defines only one abstract member, which
  // connects the services environment to the enclosing actor or test
  def actorRefFactory = context

  // this actor only runs our route, but you could add
  // other things here, like request stream processing
  // or timeout handling
  def receive = runRoute(myServiceRoute ~ myStaticRoute)
}


// this trait defines our service behavior independently from the service actor
trait MyServiceRoute extends HttpService with DefaultJsonProtocol {

  val myServiceRoute =
    pathPrefix("api" / "v1" / "sum") {
      put {
        respondWithMediaType(MediaTypes.`application/json`) { 
         entity(as[calc]) { calc =>
            val calcResult = new calc(calc.num1, calc.num2, calc.num1 + calc.num2)
            complete(calcResult)
          }
        }
      } 
    } ~ pathPrefix("api" / "v1" / "multiply") {
      put {
        respondWithMediaType(MediaTypes.`application/json`) { 
         entity(as[calc]) { calc =>
            val calcResult = new calc(calc.num1, calc.num2, calc.num1 * calc.num2)
            complete(calcResult)
          }
        }
      } 
    } ~ pathPrefix("api" / "v1" / "subtract") {
      put {
        respondWithMediaType(MediaTypes.`application/json`) { 
         entity(as[calc]) { calc =>
            val calcResult = new calc(calc.num1, calc.num2, calc.num1 - calc.num2)
            complete(calcResult)
          }
        }
      } 
    } ~ pathPrefix("api" / "v1" / "divide") {
      put {
        respondWithMediaType(MediaTypes.`application/json`) { 
         entity(as[calc]) { calc =>
            val calcResult = new calc(calc.num1, calc.num2, calc.num1 / calc.num2)
            complete(calcResult)
        }
      }
    } 
  }
}


trait MyStaticRoute extends HttpService {

  val myStaticRoute = pathPrefix("") {
    getFromDirectory("client/")
  }

}

