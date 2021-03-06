name := "calc"

organization  := "com.example"

version       := "0.1"

scalaVersion  := "2.10.5"

scalacOptions := Seq("-unchecked", "-deprecation", "-encoding", "utf8")

libraryDependencies ++= {
  val akkaV = "2.3.9"
  val sprayV = "1.3.3"
  val specs2V = "2.3.12"
  Seq(
    "io.spray"            %%  "spray-can"       % sprayV,
    "io.spray"            %%  "spray-routing"   % sprayV,
    "io.spray"            %%  "spray-json"      % "1.3.1",
    "io.spray"            %%  "spray-testkit"   % sprayV   % "test",
    "com.typesafe.akka"   %%  "akka-actor"      % akkaV,
    "com.typesafe.akka"   %%  "akka-testkit"    % akkaV    % "test",
    "org.specs2"          %%  "specs2-core"     % "2.3.7"  % "test",
    "com.novus"           %%  "salat"           % "1.9.8",
    "org.slf4j"           %   "slf4j-api"       % "1.7.7",
    "ch.qos.logback"      %   "logback-classic" % "1.0.3",
    "org.specs2"          %%  "specs2-core"     % specs2V  % "test",
    "org.scalaj"          %%  "scalaj-http"     % "1.1.4"
  )
}

test in assembly := {}

// mainClass in assembly := Some("com.example.Boot")
