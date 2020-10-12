import UIKit

public protocol TableViewCellProviding: AnyObject {

    func tableViewCell(forField field: Field) -> UITableViewCell?
}
