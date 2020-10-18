module Tests

open System
open Xunit
open FluentAssertions

[<Fact>]
let ``My test`` () =
    let x = true
    x.Should().BeTrue(null) |> ignore
