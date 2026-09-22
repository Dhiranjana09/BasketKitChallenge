# BasketKitChallenge — take-home exercise

Thanks for taking the time to do this. It's meant to take a focused 2–3
hours, not a weekend — see "Time and scope" below.

## What we're asking for

A small SwiftUI iOS app that:

1. Fetches a product catalog from the endpoint below over the network,
   using Swift Concurrency.
2. Decodes it into model type(s) you design.
3. Displays it as a browsable listing: name, brand, price, and a clear
   "sold out" state for anything with no stock left.
4. Handles three real states — loading, error, loaded — not just the happy path.
5. Lets a shopper add an in-stock item to a running basket and see a live
    total, without ever letting the basket hold more of an item than is in
    stock.

Point 5 is the part we most want to see built **test-first**. Please don't
squash your commits before sending this back — your commit history is how we'll
see your red/green/refactor process, not just the end result.

## AI Use
Here at BeautyPie we are a company that is embracing AI so feel free to use but if you do please keep a record of the prompts used and the models/providers and software used to deliver this project.

## The data

```
GET https://api.npoint.io/9467e4b907b04a8eb9cd
```

No auth, CORS-enabled, GET-only. Shape:

```json
{
  "currency": "GBP",
  "products": [
    {
      "id": "skn-001",
      "name": "Superfluid Vitamin C Serum 15%",
      "brand": "Lab No.4",
      "category": "Skincare",
      "memberPricePence": 1400,
      "rrpPence": 6800,
      "stock": 34,
      "rating": 4.7,
      "benefits": [
        "Brightens uneven tone in four weeks",
        "Softens the look of fine lines",
        "Absorbs in seconds with no tacky finish"
      ],
      "imageURL": "https://picsum.photos/seed/skn-001/600/600",
      "description": "A fast-absorbing serum that brightens tone..."
    }
  ]
}
```

14 products across Skincare, Makeup, Haircare, Fragrance and Bodycare.
Three things worth noticing before you model this: two products have
`"stock": 0`; one product omits `"rating"` entirely rather than sending it
as `null`; and `"benefits"` is ordered by importance with a length that
varies from three to five, so it isn't a fixed-size list. None of them is
a trick — they're exactly the kind of thing a real product API does, and
how you handle them is part of what we're looking at.

Prices are in pence (`Int`), not pounds (`Double`) — on purpose, for the
usual floating-point-currency reasons. `memberPricePence` is what the
shopper pays; `rrpPence` is what we'd show struck through.

## Getting started

The project targets **iOS 18** and builds in **Swift 6 language mode**,
so you'll want Xcode 16 or newer. Both are set in `project.yml`
(`deploymentTarget` and `SWIFT_VERSION`) — please leave them as they are
rather than lowering them to get something to compile.

Swift 6 mode is worth a moment's thought before you start: strict
concurrency checking is on, and data-race problems are compile *errors*,
not warnings. Anything you share across concurrency domains — a
networking client, your basket model, the types you decode — will need
to be `Sendable`, actor-isolated, or `@MainActor` to build at all. That's
deliberate; how you isolate your state is part of what we're looking at.

Open `BasketKitChallenge.xcodeproj` in Xcode and pick any iOS 18+
Simulator as the run destination. It's a single iOS app target,
`BasketKitChallenge`, with a unit test target next to it — `Cmd+R` runs
the (currently empty) app, `Cmd+U` runs the (currently empty) tests.
`Constants.productCatalogURL` already points at the endpoint above;
everything else — the model, the networking layer, the views, the basket
— is yours to design and add.

The `.xcodeproj` is generated from `project.yml` by
[XcodeGen](https://github.com/yonaskolb/XcodeGen), so it's gitignored
rather than checked in. If it's missing, or after you add a new source
file outside the existing folders, regenerate it:

```
brew install xcodegen   # once
xcodegen generate
```

Files dropped anywhere inside `BasketKitChallenge/` or
`BasketKitChallengeTests/` are picked up automatically on the next
generate — you don't need to edit `project.yml` for ordinary additions.
If you'd rather not use XcodeGen at all, commit the generated
`.xcodeproj` and work in it directly; nothing about the code changes
either way.

## Nice to have, not required

Pick at most one or two if you have time left over, and only after the
must-haves above are solid:

- Search or filter the catalog by name or category
- Sort by price
- Pull-to-refresh
- Basic image caching

## Explicitly out of scope

Authentication, real payments.

## Time and scope

Aim for 2–3 focused hours. If you run past that, stop where you are and
say so in your notes below, along with what you'd do next — a thoughtful
partial submission beats a rushed complete one, and we're not scoring
against a stopwatch.

## Submitting

A zipped Xcode project (with a .git file to track changes), or a link to a git repo (private is fine) with
its commit history intact. Please include a short written note (in this
README, or a separate NOTES.md) covering:

- How you structured the app and why
- Any assumptions you made about the data or requirements
- What you'd do differently, or add next, with more time

## What happens after

An hour follow-up call (in person preferably): you walk us through what you built, and
we'll likely ask you to extend it in a small way, live, on a share screen.
