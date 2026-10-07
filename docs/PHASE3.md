# Phase 3

## Exam engine
- Remote questions from Supabase
- Reading/listening sections
- 40-question-compatible navigation
- 50-minute session timer
- selected-answer state
- previous/next
- automatic timeout submission
- scoring and reading/listening breakdown

## Ads — development/test only
- Google rewarded test ad before starting a free test
- Google interstitial test ad after submission and before result
- Google banner test ad on the set browser
- no banner is shown inside the active exam, avoiding distraction
- production ad IDs are not present

## eSewa sandbox
The repository contains only an eSewa sandbox configuration marker. Production is hard-disabled. Payment UI/entitlement activation remains a later monetization phase because Phase 3 does not yet have premium entitlement verification.

Never commit live merchant secrets. Use server-side verification before activating paid access.

## Content
Phase 3 provides the engine. Existing EPS-TEST JSON/images/audio still need migration/upload into Supabase Storage/database before real sets can run.
