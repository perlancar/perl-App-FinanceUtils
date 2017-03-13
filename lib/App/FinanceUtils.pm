package App::FinanceUtils;

# DATE
# VERSION

use 5.010001;
use strict;
use warnings;

our %SPEC;

$SPEC{calc_fv_future_value} = {
    v => 1.1,
    summary => 'Calculate future value (FV) from present value (PV), rate of return (r), and number of periods (n)',
    description => <<'_',

The formula is:

    FV = PV*(1+r)^n

But if you use simple interest (`--simple`) where the interest is not
compounded, the formula is:

    FV = PV*(1+r*n)

_
    args => {
        pv => {
            summary => 'Present value',
            schema => ['float*'],
            req => 1,
            pos => 0,
        },
        r => {
            summary => 'Rate of return, in percent',
            schema => ['float*'],
            req => 1,
            pos => 1,
        },
        n => {
            summary => 'Number of periods',
            schema => ['float*'],
            req => 1,
            pos => 2,
        },
        simple => {
            summary => 'Use simple interest (interest not compounded)',
            schema => 'bool*',
        },
    },
    examples => [
        {
            summary => 'Invest $100 at 6% annual return rate for 5 years',
            args => {pv=>100, r=>6, n=>5},
        },
        {
            summary => 'Invest $100 at 6% annual return rate for 5 years, simple interest',
            args => {pv=>100, r=>6, n=>5, simple=>1},
        },
    ],
    result_naked => 1,
};
sub calc_fv_future_value {
    my %args = @_;

    $args{simple} ? $args{pv}*(1+$args{r}/100*$args{n}) : $args{pv}*(1+$args{r}/100)**$args{n};
}

1;
# ABSTRACT:

=head1 DESCRIPTION

This distribution contains some CLI's to do financial calculations:

# INSERT_EXECS_LIST

=cut
