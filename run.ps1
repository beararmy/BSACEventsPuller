$baseUri = 'https://www.bsac.com/events/'
$userAgent = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.5005.61 Safari/537.36'
function Get-bsacevents-numberofpages {
    param (
        $uri
    )
    $goneTooFar = 0
    $pgNum = 0
    while ($goneTooFar -ne 1) {
        $pgNum = $pgNum + 1
        $pagedUri = $uri + "?p=" + $pgNum
        $content = Invoke-WebRequest -Uri $pagedUri -UserAgent $userAgent -Method Get -UseBasicParsing
        $goneTooFar = ($content.Links | Where-Object 'href' -Like 'mailto:drt@bsac.com').Count #This should be 0. This will be 1 when you've gone a page too far.
    }
    $return = $pgNum - 1
    return $return
}
Get-bsacevents-numberofpages -uri $baseUri
